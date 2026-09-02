package com.edupath.repositories;

import com.edupath.models.College;
import com.edupath.models.SavedCollege;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface SavedCollegeRepository extends JpaRepository<SavedCollege, Long> {

    boolean existsByUser_IdAndCollege_Id(Long userId, Long collegeId);

    @Modifying
    @Transactional
    void deleteByUser_IdAndCollege_Id(Long userId, Long collegeId);

    @Query("SELECT sc.college.id FROM SavedCollege sc WHERE sc.user.id = :userId")
    List<Long> findCollegeIdsByUserId(@Param("userId") Long userId);

    @Query("SELECT sc.college FROM SavedCollege sc WHERE sc.user.id = :userId ORDER BY sc.savedAt DESC")
    List<College> findCollegesByUserId(@Param("userId") Long userId);
}
