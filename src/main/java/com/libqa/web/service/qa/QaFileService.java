package com.libqa.web.service.qa;

import com.libqa.web.domain.QaFile;

/**
 * Created by yong on 2015-03-28.
 *
 * @author yong
 */
public interface QaFileService {
    boolean moveQaFilesToProductAndSave(Integer qaId, QaFile qaFiles);
}
