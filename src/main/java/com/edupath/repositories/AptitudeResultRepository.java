package com.edupath.repositories;

import com.edupath.models.AptitudeResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AptitudeResultRepository extends JpaRepository<AptitudeResult, Long> {

    List<AptitudeResult> findByUser_IdOrderByTestDateDesc(Long userId);
}
