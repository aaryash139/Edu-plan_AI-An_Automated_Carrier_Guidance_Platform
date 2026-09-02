#!/usr/bin/env python3
"""
EduPath — Stream recommendation engine
--------------------------------------
Input (7 integers via command line):
  apt_score, pcm, comm, arts, analyst, leader, humanist

Output (stdout, one line):
  PCM | COMM | ARTS

Used by Spring Boot AptitudeApiController via ProcessBuilder.
"""

from __future__ import annotations

import json
import os
import sys
import urllib.request
import urllib.error


def compute_scores(
    apt_score: int,
    pcm: int,
    comm: int,
    arts: int,
    analyst: int,
    leader: int,
    humanist: int,
) -> dict[str, float]:
    total_l1 = pcm + comm + arts or 1
    total_l3 = analyst + leader + humanist or 1

    score_pcm = (pcm / total_l1) * 40.0 + (analyst / total_l3) * 40.0 + (apt_score / 10.0) * 20.0
    score_comm = (comm / total_l1) * 40.0 + (leader / total_l3) * 40.0 + ((10 - apt_score) / 10.0) * 10.0
    score_arts = (arts / total_l1) * 40.0 + (humanist / total_l3) * 40.0

    return {
        "PCM": round(score_pcm, 2),
        "COMM": round(score_comm, 2),
        "ARTS": round(score_arts, 2),
    }


def recommend(
    apt_score: int,
    pcm: int,
    comm: int,
    arts: int,
    analyst: int,
    leader: int,
    humanist: int,
) -> str:
    scores = compute_scores(apt_score, pcm, comm, arts, analyst, leader, humanist)
    best = max(scores, key=scores.get)
    return best


CAREER_PATHS = {
    "PCM": [
        {"role": "Software Engineer", "description": "Design, develop, and maintain software applications and systems."},
        {"role": "Mechanical Engineer", "description": "Design and manufacture mechanical systems and machinery."},
        {"role": "Data Scientist", "description": "Analyze complex data to help organizations make better decisions."},
        {"role": "Architect", "description": "Plan and design buildings and other physical structures."}
    ],
    "COMM": [
        {"role": "Chartered Accountant", "description": "Provide financial advice, audit accounts, and provide trustworthy information about financial records."},
        {"role": "Investment Banker", "description": "Help organizations raise capital and provide financial advisory services."},
        {"role": "Financial Analyst", "description": "Analyze financial data to guide business and investment decisions."},
        {"role": "Marketing Manager", "description": "Develop strategies to promote products and businesses to target audiences."}
    ],
    "ARTS": [
        {"role": "Lawyer", "description": "Advise and represent individuals, businesses, and government agencies on legal issues and disputes."},
        {"role": "Journalist", "description": "Research, write, and report news stories and current events for various media outlets."},
        {"role": "Psychologist", "description": "Study cognitive, emotional, and social processes to help individuals improve their well-being."},
        {"role": "Graphic Designer", "description": "Create visual concepts to communicate ideas that inspire and inform consumers."}
    ]
}

def get_gemini_career_paths(stream: str, apt_score: int) -> list[dict]:
    api_key = os.environ.get("GEMINI_API_KEY")
    fallback = CAREER_PATHS.get(stream, [])
    if not api_key:
        return fallback

    stream_name = {"PCM": "Science (PCM)", "COMM": "Commerce", "ARTS": "Arts and Humanities"}.get(stream, stream)
    
    prompt = (
        f"You are a career counselor. A student just took an aptitude test, scored {apt_score}/10, and was recommended the '{stream_name}' stream. "
        "Suggest exactly 4 potential future career paths for this student based on this stream. "
        "Return the response as a raw JSON array of objects. Do NOT use markdown code blocks like ```json. Just output the raw JSON array. "
        "Each object must have exactly two string keys: 'role' (the job title) and 'description' (a brief 1-2 sentence explanation of the role)."
    )
    
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={api_key}"
    data = json.dumps({
        "contents": [{"parts": [{"text": prompt}]}]
    }).encode("utf-8")
    
    req = urllib.request.Request(url, data=data, headers={"Content-Type": "application/json"})
    try:
        with urllib.request.urlopen(req, timeout=8) as response:
            res_body = response.read()
            res_json = json.loads(res_body)
            text_response = res_json.get("candidates", [{}])[0].get("content", {}).get("parts", [{}])[0].get("text", "")
            
            text_response = text_response.strip()
            if text_response.startswith("```json"):
                text_response = text_response[7:]
            if text_response.startswith("```"):
                text_response = text_response[3:]
            if text_response.endswith("```"):
                text_response = text_response[:-3]
                
            parsed = json.loads(text_response.strip())
            if isinstance(parsed, list) and len(parsed) > 0 and "role" in parsed[0]:
                return parsed
            return fallback
    except Exception:
        return fallback


def main() -> None:
    # JSON mode: python recommend.py --json '{"level1":{...}, ...}'
    if len(sys.argv) == 3 and sys.argv[1] == "--json":
        payload = json.loads(sys.argv[2])
        l1 = payload.get("level1", {})
        l2 = payload.get("level2", {})
        l3 = payload.get("level3", {})
        stream = recommend(
            int(l2.get("aptitude_score", 0)),
            int(l1.get("pcm", 0)),
            int(l1.get("comm", 0)),
            int(l1.get("arts", 0)),
            int(l3.get("analyst", 0)),
            int(l3.get("leader", 0)),
            int(l3.get("humanist", 0)),
        )
        scores = compute_scores(
            int(l2.get("aptitude_score", 0)),
            int(l1.get("pcm", 0)),
            int(l1.get("comm", 0)),
            int(l1.get("arts", 0)),
            int(l3.get("analyst", 0)),
            int(l3.get("leader", 0)),
            int(l3.get("humanist", 0)),
        )
        out = {
            "recommendation": stream,
            "recommended_stream": {
                "PCM": "PCM",
                "COMM": "COMMERCE",
                "ARTS": "ARTS_HUMANITIES",
            }[stream],
            "career_path_details": get_gemini_career_paths(stream, int(l2.get("aptitude_score", 0))),
            "aptitude_score": int(l2.get("aptitude_score", 0)),
            "scores": scores,
            "engine": "python",
        }
        print(json.dumps(out))
        return

    if len(sys.argv) != 8:
        print("Usage: recommend.py <apt> <pcm> <comm> <arts> <analyst> <leader> <humanist>", file=sys.stderr)
        sys.exit(1)

    apt_score, pcm, comm, arts, analyst, leader, humanist = (int(x) for x in sys.argv[1:8])
    print(recommend(apt_score, pcm, comm, arts, analyst, leader, humanist))


if __name__ == "__main__":
    main()
