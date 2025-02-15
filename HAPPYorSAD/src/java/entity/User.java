/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Ann
 */
public class User {

    private String avatarPath, username, fullname, password,
            status, email, phoneNumber, address; // add fullname, address
    private Date dateOfBirth, createdAt;
    private String gender, role;
    private boolean isGuest;
    private String bio;
    private int id;

    public User() {
    }
        public User(int id) {
        this.id = id;
    }

    public User(String username, String fullname, String email, String phoneNumber, Date createdAt, String bio) {
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.createdAt = createdAt;
        this.bio = bio;
    }
    
    
    
    

    public User(String avatarPath, String username, String fullname, String password, String status, String email, String phoneNumber, String address, Date dateOfBirth, Date createdAt, String gender, String role, boolean isGuest) {
        this.avatarPath = avatarPath;
        this.username = username;
        this.fullname = fullname;
        this.password = password;
        this.status = status;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.createdAt = createdAt;
        this.gender = gender;
        this.role = role;
        this.isGuest = isGuest;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }
    
    

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isIsGuest() {
        return isGuest;
    }

    public void setIsGuest(boolean isGuest) {
        this.isGuest = isGuest;
    }

    @Override
    public String toString() {
        return "User{" + "avatarPath=" + avatarPath + ", username=" + username + ", fullname=" + fullname + ", password=" + password + ", status=" + status + ", email=" + email + ", phoneNumber=" + phoneNumber + ", address=" + address + ", dateOfBirth=" + dateOfBirth + ", createdAt=" + createdAt + ", gender=" + gender + ", role=" + role + ", isGuest=" + isGuest + ", bio=" + bio + ", id=" + id + '}';
    }

   
    
}
