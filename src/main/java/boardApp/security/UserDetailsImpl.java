package boardApp.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import boardApp.VO.UserVO;

public class UserDetailsImpl implements UserDetails {
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	
	private final UserVO userVO;
	
	public UserDetailsImpl(UserVO userVO) {
		this.userVO = userVO;
	}
	
	public UserVO getUserVO() {
		return userVO;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities(){
		ArrayList<GrantedAuthority> auth = new ArrayList<>();
		auth.add(new SimpleGrantedAuthority(userVO.getUserAuthority()));
		return auth;
	}
	
	@Override
	public String getPassword() {return userVO.getUserPw();}
	
	@Override
	public String getUsername() {return userVO.getUserId();}
	
	@Override
	public boolean isAccountNonExpired() {return true;}
	
	@Override
	public boolean isAccountNonLocked() {return true;}
	
	@Override
	public boolean isCredentialsNonExpired() {return true;}
	
	@Override
	public boolean isEnabled() {return "1".equals(userVO.getUserEnabled());}
}
