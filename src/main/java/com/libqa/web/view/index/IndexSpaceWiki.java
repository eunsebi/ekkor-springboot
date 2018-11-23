package com.libqa.web.view.index;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor(staticName = "of")
public class IndexSpaceWiki {
    private Integer wikiId;
    private String title;
    private String description;
    private Integer spaceId;
}
