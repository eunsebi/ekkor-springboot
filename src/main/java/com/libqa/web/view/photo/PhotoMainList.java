package com.libqa.web.view.photo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author : yion
 * @Date : 2016. 3. 27.
 * @Description :
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PhotoMainList {
    private Integer currentPage;
    private Integer totalPages;
    private Long totalElements;
    private List<PhotoMain> spaceMainList;
}
