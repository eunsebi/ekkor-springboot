package com.libqa.web.view.photo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author : yion
 * @Date : 2015. 8. 23.
 * @Description :
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PhotoWikiList {
    private Integer currentPage;
    private Integer totalPages;
    private Long totalElements;
    private List<PhotoWiki> spaceWikiList;
}
