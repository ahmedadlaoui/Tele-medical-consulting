package com.example.med_consulting.Util;

import com.example.med_consulting.Model.Enum.SlotStatus;
import com.example.med_consulting.Model.TimeSlot;
import com.example.med_consulting.Repository.Interfaces.UserRepositoryInterface;
import com.example.med_consulting.Repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;

import java.time.LocalDateTime;

public class TimeSlotMapper {
    public TimeSlot buildTimeSlotObject(HttpServletRequest request, String email) {
        TimeSlot timeSlot = new TimeSlot();
        try{
            SlotStatus status = SlotStatus.valueOf(request.getParameter("status"));
            timeSlot.setStatus(status);

            LocalDateTime startDateTime = LocalDateTime.parse(request.getParameter("startTime"));
            LocalDateTime endDateTime = LocalDateTime.parse(request.getParameter("endTime"));
            timeSlot.setStartTime(startDateTime);
            timeSlot.setEndTime(endDateTime);

            UserRepositoryInterface userRepository = new UserRepository();
            timeSlot.setDoctor(userRepository.getUserByEmail(email));

        return timeSlot;
        }catch(Exception e){
            System.out.println("Error building WaitingQueue object" + e.getMessage());
            return null;
        }
    }
}
