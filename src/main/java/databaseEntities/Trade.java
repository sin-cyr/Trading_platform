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


//Trades
@Entity
@Table(name = "trades")
public class Trade {
	
	@Id
	@SequenceGenerator(name = "trade_seq", sequenceName = "TODO_SEQ")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "trade_seq")
	private Long tradeId;
	
	@ManyToOne
	@JoinColumn(name="buyer_id")
	private User buyer;

	@ManyToOne
	@JoinColumn(name="seller_id")
	private User seller;
	
	@ManyToOne(cascade=CascadeType.PERSIST)
	private Share share;
	
	private Timestamp transactionTime;
	private double quantity;
	private double priceTotal;
	
	public User getBuyer() {
		return buyer;
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	public User getSeller() {
		return seller;
	}

	public void setSeller(User seller) {
		this.seller = seller;
	}

	public Share getShare() {
		return share;
	}

	public void setShare(Share share) {
		this.share = share;
	}

	public Long getTradeId() {
		return tradeId;
	}
	
	public void setTradeId(Long tradeId) {
		this.tradeId = tradeId;
	}
	

	public Timestamp getTransactionTime() {
		return transactionTime;
	}
	
	public void setTransactionTime(Timestamp transactionTime) {
		this.transactionTime = transactionTime;
	}
	
	public double getQuantity() {
		return quantity;
	}
	
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getPriceTotal() {
		return priceTotal;
	}

	public void setPriceTotal(double priceTotal) {
		this.priceTotal = priceTotal;
	}
	
}
