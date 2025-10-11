package com.example.med_consulting.Model;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("GENERAL_PRACTITIONER")
public class GeneralPractitioner extends User {


}