package com.edupath.models;

import jakarta.persistence.*;

@Entity
@Table(name = "colleges")
public class College {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "college_id")
    private Long id;

    @Column(nullable = false, length = 180)
    private String name;

    @Column(nullable = false, length = 120)
    private String city;

    @Column(nullable = false, length = 120)
    private String state;

    @Column(name = "college_type", nullable = false, length = 120)
    private String collegeType;

    @Column(nullable = false, length = 120)
    private String stream;

    @Column(nullable = false)
    private Integer fees;

    @Column(nullable = false)
    private Integer cutoff;

    @Column(name = "nirf_rank", nullable = false)
    private Integer nirfRank;

    @Column(name = "entrance_exam", length = 80)
    private String entranceExam;

    private Double rating = 0.0;

    private String placementRate = "80%";
    private String avgPackage = "₹5 LPA";
    private String topRecruiters = "TCS, Infosys, Wipro, Cognizant";
    private String facilities = "Hostel, Library, Wi-Fi Campus, Sports Complex, Labs";

    public College() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getCollegeType() { return collegeType; }
    public void setCollegeType(String collegeType) { this.collegeType = collegeType; }

    public String getStream() { return stream; }
    public void setStream(String stream) { this.stream = stream; }

    public Integer getFees() { return fees; }
    public void setFees(Integer fees) { this.fees = fees; }

    public Integer getCutoff() { return cutoff; }
    public void setCutoff(Integer cutoff) { this.cutoff = cutoff; }

    public Integer getNirfRank() { return nirfRank; }
    public void setNirfRank(Integer nirfRank) { this.nirfRank = nirfRank; }

    public String getEntranceExam() { return entranceExam; }
    public void setEntranceExam(String entranceExam) { this.entranceExam = entranceExam; }

    public Double getRating() { return rating; }
    public void setRating(Double rating) { this.rating = rating; }

    public String getPlacementRate() { return placementRate; }
    public void setPlacementRate(String placementRate) { this.placementRate = placementRate; }

    public String getAvgPackage() { return avgPackage; }
    public void setAvgPackage(String avgPackage) { this.avgPackage = avgPackage; }

    public String getTopRecruiters() { return topRecruiters; }
    public void setTopRecruiters(String topRecruiters) { this.topRecruiters = topRecruiters; }

    public String getFacilities() { return facilities; }
    public void setFacilities(String facilities) { this.facilities = facilities; }
}
