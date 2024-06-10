package himedia.dao;

import java.util.List;

public interface EmailDao {
	public List<EmailVo> getList();	//	emaillist table SELECT
	public boolean insert(EmailVo vo);	//	emaillist table INSERT
	public boolean delete(String no); //	emaillist table DELETE
}
