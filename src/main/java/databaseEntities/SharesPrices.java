package databaseEntities;


import java.sql.Timestamp;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "sharesprices")
public class SharesPrices {

	// Have a date and use this entity to track datdde price changes
	@Id
	@SequenceGenerator(name = "share_guide_price_seq", sequenceName = "TODO_SEQ")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "share_guide_price_seq")
	private Long sharespricesId;

	@OneToOne(cascade = CascadeType.MERGE)
	private Share share;
	private double price;
	private Timestamp timestamp;

	public Long getSharespricesId() {
		return sharespricesId;
	}

	public void setSharespricesId(Long sharespricesId) {
		this.sharespricesId = sharespricesId;
	}

	public Share getShare() {
		return share;
	}

	public void setShare(Share share) {
		this.share = share;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}
	
	public String toString(){
		return String.valueOf(price);
	}

}
