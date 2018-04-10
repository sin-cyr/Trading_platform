package databaseEntities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

//Shares_owned
@Entity
@Table(name = "ownedShares")
public class OwnedShare {
	
	@Id
	@SequenceGenerator(name = "owned_share_seq", sequenceName = "TODO_SEQ")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "owned_share_seq")	
	private long ownedShareId;
	
	@ManyToOne(cascade = CascadeType.PERSIST)
	private Share share;	
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	private double quantity;
	private double pricePerShare;

	public long getOwnedShareId() {
		return ownedShareId;
	}

	public void setOwnedShareId(long ownedShareId) {
		this.ownedShareId = ownedShareId;
	}

	public Share getShare() {
		return share;
	}

	public void setShare(Share share) {
		this.share = share;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getPricePerShare() {
		return pricePerShare;
	}

	public void setPricePerShare(double pricePerShare) {
		this.pricePerShare = pricePerShare;
	}

}
