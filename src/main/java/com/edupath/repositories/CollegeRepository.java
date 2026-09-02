package com.edupath.repositories;

import com.edupath.models.College;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CollegeRepository extends JpaRepository<College, Long> {

    @Query("""
        SELECT c FROM College c
        WHERE (:search = '' OR LOWER(c.name) LIKE LOWER(CONCAT('%', :search, '%'))
               OR LOWER(c.city) LIKE LOWER(CONCAT('%', :search, '%')))
          AND (:state = '' OR c.state = :state)
          AND (:stream = '' OR c.stream = :stream)
          AND (:type = '' OR c.collegeType = :type)
          AND c.fees <= :maxFees
          AND c.cutoff >= :minCutoff
          AND c.nirfRank <= :maxRank
        """)
    List<College> searchColleges(
            @Param("search") String search,
            @Param("state") String state,
            @Param("stream") String stream,
            @Param("type") String type,
            @Param("maxFees") int maxFees,
            @Param("minCutoff") int minCutoff,
            @Param("maxRank") int maxRank
    );

    @Query("""
        SELECT c FROM College c
        WHERE c.state = :state 
          AND c.stream = :stream
          AND c.cutoff <= :percentage
        ORDER BY c.nirfRank ASC
        """)
    List<College> findRecommendations(
            @Param("state") String state, 
            @Param("stream") String stream, 
            @Param("percentage") int percentage
    );

    @Query("""
        SELECT c FROM College c
        WHERE c.state != :state 
          AND c.stream = :stream
          AND c.cutoff <= :percentage
        ORDER BY c.nirfRank ASC
        """)
    List<College> findBeyondStateRecommendations(
            @Param("state") String state, 
            @Param("stream") String stream, 
            @Param("percentage") int percentage
    );
}
