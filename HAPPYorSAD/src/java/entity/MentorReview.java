/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.time.LocalDateTime;
import model.DAOuser;

/**
 *
 * @author admin
 */
public class MentorReview {

    private int id;
    private int mentorID;
    private int menteeID;
    private int rating;
    private String commit;
    private LocalDateTime createdAt;
    private String name;
    private String image;

    public MentorReview() {
    }

    public MentorReview(int menteeID, int rating, String commit) {
        this.menteeID = menteeID;
        this.rating = rating;
        this.commit = commit;
    }

    public MentorReview(int rating, String commit, String name, String image) {
        this.rating = rating;
        this.commit = commit;
        this.name = name;
        this.image = image;
    }

    public MentorReview(int id, int mentorID, int menteeID, int rating, String commit, LocalDateTime createdAt, String name, String image) {
        this.id = id;
        this.mentorID = mentorID;
        this.menteeID = menteeID;
        this.rating = rating;
        this.commit = commit;
        this.createdAt = createdAt;
        this.name = name;
        this.image = image;
    }

    public MentorReview(int id, int mentorID, int menteeID, int rating, String commit, LocalDateTime createdAt) {
        this.id = id;
        this.mentorID = mentorID;
        this.menteeID = menteeID;
        this.rating = rating;
        this.commit = commit;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMentorID() {
        return mentorID;
    }

    public void setMentorID(int mentorID) {
        this.mentorID = mentorID;
    }

    public int getMenteeID() {
        return menteeID;
    }

    public void setMenteeID(int menteeID) {
        this.menteeID = menteeID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getCommit() {
        return commit;
    }

    public void setCommit(String commit) {
        this.commit = commit;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public User getMentee() {
        DAOuser dao = new DAOuser();
        return dao.getMenteeById(this.menteeID);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "MentorReview{" + "id=" + id + ", mentorID=" + mentorID + ", menteeID=" + menteeID + ", rating=" + rating + ", commit=" + commit + ", createdAt=" + createdAt + ", name=" + name + ", image=" + image + '}';
    }

}
