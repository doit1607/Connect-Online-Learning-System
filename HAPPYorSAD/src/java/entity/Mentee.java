/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author dungb
 */
public class Mentee {

    private String name;
    private String accountName;
    private int numberOfMentee;
    private double totalHours;
    private int totalCourses;

    public Mentee() {
    }

    public Mentee(String name, String accountName, int numberOfMentee, double totalHours, int totalCourses) {
        this.name = name;
        this.accountName = accountName;
        this.numberOfMentee = numberOfMentee;
        this.totalHours = totalHours;
        this.totalCourses = totalCourses;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public int getNumberOfMentee() {
        return numberOfMentee;
    }

    public void setNumberOfMentee(int numberOfMentee) {
        this.numberOfMentee = numberOfMentee;
    }

    public double getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(double totalHours) {
        this.totalHours = totalHours;
    }

    public int getTotalCourses() {
        return totalCourses;
    }

    public void setTotalCourses(int totalCourses) {
        this.totalCourses = totalCourses;
    }
}
