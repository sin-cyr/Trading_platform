package databaseEntities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "TrackedShare")
public class TrackedShare {

	@Id
	@SequenceGenerator(name = "tracked_trade_seq", sequenceName = "TODO_SEQ")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "tracked_trade_seq")
	private Long trackedId;

	@OneToOne(cascade = CascadeType.MERGE)
	private SharesPrices sharePrice;

	@ManyToOne(cascade = CascadeType.MERGE)
	private User user;

	public SharesPrices getSharePrice() {
		return sharePrice;
	}

	public void setSharePrice(SharesPrices sharePrice) {
		this.sharePrice = sharePrice;
	}

	public Long getTrackedId() {
		return trackedId;
	}

	public void setTrackedId(Long trackedId) {
		this.trackedId = trackedId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
