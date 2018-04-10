package databaseEntities;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

//Shares
@Entity
@Table(name="shares")
public class Share {

	@Id
	@SequenceGenerator(name = "share_seq", sequenceName = "TODO_SEQ")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "share_seq")
	private Long shareId;
	
	@ManyToOne(cascade=CascadeType.MERGE)
	private Company company;

	public Long getShareId() {
		return shareId;
	}

	public void setShareId(Long shareId) {
		this.shareId = shareId;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	@Override
	public String toString() {
		return "" + shareId ;
	}
	
	
}
