package com.edupath.dto;

import com.edupath.models.College;

public class CollegeDto {

    private Long id;
    private String name;
    private String city;
    private String state;
    private String type;
    private String stream;
    private int fees;
    private int cutoff;
    private int rank;
    private String exam;
    private double rating;

    public static CollegeDto from(College college) {
        CollegeDto dto = new CollegeDto();
        dto.id = college.getId();
        dto.name = college.getName();
        dto.city = college.getCity();
        dto.state = college.getState();
        dto.type = college.getCollegeType();
        dto.stream = college.getStream();
        dto.fees = college.getFees();
        dto.cutoff = college.getCutoff();
        dto.rank = college.getNirfRank();
        dto.exam = college.getEntranceExam() != null ? college.getEntranceExam() : "";
        dto.rating = college.getRating() != null ? college.getRating() : 0.0;
        return dto;
    }

    public Long getId() { return id; }
    public String getName() { return name; }
    public String getCity() { return city; }
    public String getState() { return state; }
    public String getType() { return type; }
    public String getStream() { return stream; }
    public int getFees() { return fees; }
    public int getCutoff() { return cutoff; }
    public int getRank() { return rank; }
    public String getExam() { return exam; }
    public double getRating() { return rating; }
}
