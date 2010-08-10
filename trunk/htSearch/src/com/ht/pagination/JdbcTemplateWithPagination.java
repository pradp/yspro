package com.ht.pagination;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConstructorUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

/**
 * JdbcTemplate的扩展类,加入分页查询的方法(方法名为原有方法名+WithPagination)
 * 
 * 
 */

public class JdbcTemplateWithPagination extends JdbcTemplate {

	private PaginationSQLGetter paginationSQLGetter;

	public JdbcTemplateWithPagination() {
		super();
	}

	public JdbcTemplateWithPagination(DataSource dataSource) {
		super(dataSource);
	}

	public JdbcTemplateWithPagination(DataSource dataSource, boolean lazyInit) {
		super(dataSource, lazyInit);
	}

	public void setPaginationSQLGetter(PaginationSQLGetter paginationSQLGetter) {
		this.paginationSQLGetter = paginationSQLGetter;
	}

	public List queryWithPagination(String sql, RowMapper rowMapper) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql));
		setRecordCount(recordCount);
		List result = query(getPaginationSQL(sql), rowMapper);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return query(getPaginationSQL(sql), rowMapper);
	}

	public List queryWithPagination(String sql, Object[] args, int[] argTypes, RowMapper rowMapper) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql), args, argTypes);
		setRecordCount(recordCount);
		List result = query(getPaginationSQL(sql), args, argTypes, rowMapper);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return query(getPaginationSQL(sql), args, argTypes, rowMapper);
	}

	public List queryWithPagination(String sql, Object[] args, RowMapper rowMapper) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql), args);
		setRecordCount(recordCount);
		List result = query(getPaginationSQL(sql), args, rowMapper);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return query(getPaginationSQL(sql), args, rowMapper);
	}

	public List queryForListWithPagination(String sql) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql));
		setRecordCount(recordCount);
		List result = queryForList(getPaginationSQL(sql));
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return queryForList(getPaginationSQL(sql));
	}

	public List queryForListWithPagination(String sql, Object[] args) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql), args);
		setRecordCount(recordCount);
		List result = queryForList(getPaginationSQL(sql), args);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return queryForList(getPaginationSQL(sql), args);
	}

	public List queryForListWithPagination(String sql, Object[] args, int[] argTypes) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql), args, argTypes);
		setRecordCount(recordCount);
		List result = queryForList(getPaginationSQL(sql), args, argTypes);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return queryForList(getPaginationSQL(sql), args, argTypes);
	}

	public List queryForListWithPagination(String sql, Object[] args, int[] argTypes, Class elementType) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql), args, argTypes);
		setRecordCount(recordCount);
		List result = queryForList(getPaginationSQL(sql), args, argTypes, elementType);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return queryForList(getPaginationSQL(sql), args, argTypes, elementType);
	}

	public List queryForListWithPagination(String sql, Object[] args, Class elementType) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql), args);
		setRecordCount(recordCount);
		List result = queryForList(getPaginationSQL(sql), args, elementType);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return queryForList(getPaginationSQL(sql), args, elementType);
	}

	public List queryForListWithPagination(String sql, Class elementType) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql));
		setRecordCount(recordCount);
		List result = queryForList(getPaginationSQL(sql), elementType);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return queryForList(getPaginationSQL(sql), elementType);
	}

	public List queryForPOJOListWithPagination(String sql, Object[] args, Class pojoClass) throws DataAccessException {
		int recordCount = queryForInt(getCountSQL(sql), args);
		setRecordCount(recordCount);
		List result = queryForPOJOList(getPaginationSQL(sql), args, pojoClass);
		if (result != null && !result.isEmpty())
			return result;
		setPageIndexToLast();
		return queryForPOJOList(getPaginationSQL(sql), args, pojoClass);
	}

	public List queryForPOJOList(String sql, Object[] args, Class pojoClass) throws DataAccessException {
		List list = queryForList(sql, args);
		if (list == null)
			return null;
		List pojoList = new ArrayList();
		try {
			for (int i = 0; i < list.size(); i++) {
				Object pojo = ConstructorUtils.invokeConstructor(pojoClass, null);
				BeanUtils.copyProperties(pojo, list.get(i));
				pojoList.add(pojo);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return pojoList;
	}

	protected String getPaginationSQL(String originalSql) {
		PaginationContext context = PaginationContextHolder.getPaginationContext();
		int first = context.getFirst();
		int pageSize = context.getPageSize();
		return paginationSQLGetter.getPaginationSQL(originalSql, first, pageSize);
	}

	protected String getCountSQL(String originalSql) {
		return paginationSQLGetter.getCountSQL(originalSql);
	}

	protected void setRecordCount(int recordCount) {
		PaginationContext context = PaginationContextHolder.getPaginationContext();
		context.setRecordCount(recordCount);
	}

	protected void setPageIndexToLast() {
		PaginationContext context = PaginationContextHolder.getPaginationContext();
		context.setPageIndexToLast();
	}
}
