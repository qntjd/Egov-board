package boardApp.VO;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserVO {
	
	public static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	
	private int userNo;
	private String userId;
	private String userPw;
	private String userName;
	private String email;
	private String phoneNumber;
	private String gender;
	private String birth;
	
	private String userAuthority;
	private String userEnabled;
	
	public int getUserNo() {return userNo;}
	public void setUserNo(int userNo) {this.userNo = userNo;}
	
	public String getUserId() {return userId;}
	public void setUserId(String userId) {this.userId = userId;}
	
	public String getUserPw() {return userPw;}
	public void setUserPw(String userPw) {this.userPw = userPw;}
	
	public String getUserName() {return userName;}
	public void setUserName(String userName) {this.userName = userName;}
	
	public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}
	
	public String getPhoneNumber() {return phoneNumber;}
	public void setPhoneNumber(String phoneNumber) {this.phoneNumber =phoneNumber;}
	
	public String getGender() {return gender;}
	public void setGender(String gender) {this.gender =gender;}
	
	public String getBirth() {return birth;}
	public void setBirth(String birth) {this.birth = birth;}
	
	public String getUserAuthority(){return userAuthority;}
	public void setUserAuthority(String userAuthority) {this.userAuthority = userAuthority;} 
	
	public String getUserEnabled() {return userEnabled;}
	public void setUserEnabled(String userEnabled) {this.userEnabled = userEnabled;}
	

}
