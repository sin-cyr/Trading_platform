package databaseEntities;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;



//Shares_Prices
@Entity
@Table(name="currentTrades")
public class CurrentTrade {

	@Id
	@SequenceGenerator(name = "current_trades_seq", sequenceName = "TODO_SEQ")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "current_trades_seq")
	private Long sharePriceId;
	
	@ManyToOne(cascade=CascadeType.MERGE)
	@JoinColumn(name="share_id")
	private Share share;
	private double buyPrice;
	private  double sellPrice;
	private Timestamp timePosted;
	private double amountBuying;
	private double amountSelling;
	
	@ManyToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="user_id")
	private User user;

	public Long getSharePriceId() {
		return sharePriceId;
	}

	public void setSharePriceId(Long sharePriceId) {
		this.sharePriceId = sharePriceId;
	}

	public Share getShare() {
		return share;
	}

	public void setShare(Share share) {
		this.share = share;
	}


	public Timestamp getTimePosted() {
		return timePosted;
	}

	public void setTimePosted(Timestamp timePosted) {
		this.timePosted = timePosted;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public double getBuyPrice() {
		return buyPrice;
	}

	public void setBuyPrice(double buyPrice) {
		this.buyPrice = buyPrice;
	}

	public double getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(double sellPrice) {
		this.sellPrice = sellPrice;
	}

	public double getAmountBuying() {
		return amountBuying;
	}

	public void setAmountBuying(double amountBuying) {
		this.amountBuying = amountBuying;
	}

	public double getAmountSelling() {
		return amountSelling;
	}

	public void setAmountSelling(double amountSelling) {
		this.amountSelling = amountSelling;
	}

	@Override
	public String toString() {
		return "" + sharePriceId ;
	}
	
	
}
