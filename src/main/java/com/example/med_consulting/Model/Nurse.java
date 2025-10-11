package com.example.med_consulting.Model;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("NURSE")
public class Nurse extends User {

}