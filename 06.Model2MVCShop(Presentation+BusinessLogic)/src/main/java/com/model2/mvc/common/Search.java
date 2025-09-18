package com.model2.mvc.common;

// 리스트 화면 공통 검색/페이징 Bean
public class Search {

    // --- Core fields ---
    private int currentPage = 1;      // canonical page
    private String searchCondition;
    private String searchKeyword;

    private int pageSize = 10;        // rows per page
    private int pageUnit = 10;        // pages per pager block (for UI)

    // ROWNUM bounds (can be computed on the fly; setters still supported)
    private int startRowNum;
    private int endRowNum;

    // --- Alias getters for JSP compatibility ---
    // allow ${searchVO.page}
    public int getPage() { return currentPage; }
    public void setPage(int page) { this.currentPage = page; }

    // allow ${searchVO.pageUnit}
    public int getPageUnit() { return pageUnit; }
    public void setPageUnit(int pageUnit) { this.pageUnit = pageUnit; }

    // --- Canonical getters/setters ---
    public int getCurrentPage() { return currentPage; }
    public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }

    public String getSearchCondition() { return searchCondition; }
    public void setSearchCondition(String searchCondition) { this.searchCondition = searchCondition; }

    public String getSearchKeyword() { return searchKeyword; }
    public void setSearchKeyword(String searchKeyword) { this.searchKeyword = searchKeyword; }

    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; } // <-- typo fixed

    // Compute when not explicitly set, else return the set value
    public int getStartRowNum() {
        if (startRowNum > 0) return startRowNum;
        int page = getPage() <= 0 ? 1 : getPage();
        int size = getPageSize() > 0 ? getPageSize() : 10;
        return (page - 1) * size + 1;
    }
    public void setStartRowNum(int startRowNum) { this.startRowNum = startRowNum; }

    public int getEndRowNum() {
        if (endRowNum > 0) return endRowNum;
        int page = getPage() <= 0 ? 1 : getPage();
        int size = getPageSize() > 0 ? getPageSize() : 10;
        return page * size;
    }
    public void setEndRowNum(int endRowNum) { this.endRowNum = endRowNum; }

    @Override
    public String toString() {
        return "Search{" +
                "currentPage=" + currentPage +
                ", searchCondition='" + searchCondition + '\'' +
                ", searchKeyword='" + searchKeyword + '\'' +
                ", pageSize=" + pageSize +
                ", pageUnit=" + pageUnit +
                ", startRowNum=" + getStartRowNum() +
                ", endRowNum=" + getEndRowNum() +
                '}';
    }
}
