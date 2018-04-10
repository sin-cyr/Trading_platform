package databaseEntities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

//Users
@Entity
@Table(name = "users")
public class User {

	@Id
	@SequenceGenerator(name = "user_seq", sequenceName = "TODO_SEQ")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_seq")
	private Long userId;
	private String username;
	private String password;
	private String email;
	private double credit;
	private int adminBoolean;
	private int banned;

	@Lob
	private byte[] imageFile;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "buyer")
	private List<Trade> boughtTrades;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "seller")
	private List<Trade> soldTrades;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "user", orphanRemoval = true)
	private List<OwnedShare> ownedShares;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "user")
	private List<CurrentTrade> currentTrades;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "user", orphanRemoval = true)
	private List<TrackedShare> trackedShares;

	public double getCredit() {
		return credit;
	}

	public void setCredit(double credit) {
		this.credit = credit;
	}

	public List<TrackedShare> getTrackedShares() {
		return trackedShares;
	}

	public void setTrackedShares(List<TrackedShare> trackedShares) {
		this.trackedShares = trackedShares;
	}

	public List<OwnedShare> getOwnedShares() {
		return ownedShares;
	}

	public void setOwnedShares(List<OwnedShare> ownedShares) {
		this.ownedShares = ownedShares;
	}

	public List<CurrentTrade> getCurrentTrades() {
		return currentTrades;
	}

	public void setCurrentTrades(List<CurrentTrade> currentTrades) {
		this.currentTrades = currentTrades;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<Trade> getBoughtTrades() {
		return boughtTrades;
	}

	public void setBoughtTrades(List<Trade> boughtTrades) {
		this.boughtTrades = boughtTrades;
	}

	public List<Trade> getSoldTrades() {
		return soldTrades;
	}

	public void setSoldTrades(List<Trade> soldTrades) {
		this.soldTrades = soldTrades;
	}

	public int getAdminBoolean() {
		return adminBoolean;
	}

	public void setAdminBoolean(int adminBoolean) {
		this.adminBoolean = adminBoolean;
	}

	public byte[] getImageFile() {
		return imageFile;
	}

	public void setImageFile(byte[] imageFile) {
		this.imageFile = imageFile;
	}

	public int getBanned() {
		return banned;
	}

	public void setBanned(int banned) {
		this.banned = banned;
	}

}
