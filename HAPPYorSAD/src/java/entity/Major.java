/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author admin
 */
public class Major {

    private String description;
    private int id;
    private String image;
    private String name;
    private int total_courses;

    public Major() {
    }

    public Major(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public Major(String name, String image, int total_courses) {
        this.image = image;
        this.name = name;
        this.total_courses = total_courses;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getTotal_courses() {
        return total_courses;
    }

    public void setTotal_courses(int total_courses) {
        this.total_courses = total_courses;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Major{" + "description=" + description + ", id=" + id + ", image=" + image + ", name=" + name + ", total_courses=" + total_courses + '}';
    }

}
