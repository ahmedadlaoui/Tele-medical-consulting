package com.example.med_consulting.Service;

import com.example.med_consulting.DAO.Interfaces.TimeSlotDAOInterface;
import com.example.med_consulting.DAO.TimeSlotDAO;
import com.example.med_consulting.Model.TimeSlot;

public class TimeSlotService {

    public boolean addTimeSlot(TimeSlot timeSlot) {
        if (timeSlot == null) {
            return false;
        }
        TimeSlotDAOInterface timeSlotDAO = new TimeSlotDAO();
        return timeSlotDAO.insertTimeSlot(timeSlot);
    }

}
