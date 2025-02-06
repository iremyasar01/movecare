class SearchModel {
	String? kind;
	String? etag;
	String? nextPageToken;
	String? regionCode;
	PageInfo? pageInfo;
	List<SearchItems>? searchItems;

	SearchModel({this.kind, this.etag, this.nextPageToken, this.regionCode, this.pageInfo, this.searchItems});

	SearchModel.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		etag = json['etag'];
		nextPageToken = json['nextPageToken'];
		regionCode = json['regionCode'];
		pageInfo = json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
		if (json['items'] != null) {
			searchItems = <SearchItems>[];
			json['items'].forEach((v) { searchItems!.add(SearchItems.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['kind'] = kind;
		data['etag'] = etag;
		data['nextPageToken'] = nextPageToken;
		data['regionCode'] = regionCode;
		if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
		if (searchItems != null) {
      data['items'] = searchItems!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class PageInfo {
	int? totalResults;
	int? resultsPerPage;

	PageInfo({this.totalResults, this.resultsPerPage});

	PageInfo.fromJson(Map<String, dynamic> json) {
		totalResults = json['totalResults'];
		resultsPerPage = json['resultsPerPage'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['totalResults'] = totalResults;
		data['resultsPerPage'] = resultsPerPage;
		return data;
	}
}

class SearchItems {
	String? kind;
	String? etag;
	Id? id;
	Search? search;

	SearchItems({this.kind, this.etag, this.id, this.search});

	SearchItems.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		etag = json['etag'];
		id = json['id'] != null ? Id.fromJson(json['id']) : null;
		search = json['snippet'] != null ? Search.fromJson(json['snippet']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['kind'] = kind;
		data['etag'] = etag;
		if (id != null) {
      data['id'] = id!.toJson();
    }
		if (search != null) {
      data['snippet'] = search!.toJson();
    }
		return data;
	}
}

class Id {
	String? kind;
	String? videoId;
	String? playlistId;

	Id({this.kind, this.videoId, this.playlistId});

	Id.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		videoId = json['videoId'];
		playlistId = json['playlistId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['kind'] = kind;
		data['videoId'] = videoId;
		data['playlistId'] = playlistId;
		return data;
	}
}

class Search {
	String? publishedAt;
	String? channelId;
	String? title;
	String? description;
	Thumbnails? thumbnails;
	String? channelTitle;
	String? liveBroadcastContent;
	String? publishTime;

	Search({this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.liveBroadcastContent, this.publishTime});

	Search.fromJson(Map<String, dynamic> json) {
		publishedAt = json['publishedAt'];
		channelId = json['channelId'];
		title = json['title'];
		description = json['description'];
		thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
		channelTitle = json['channelTitle'];
		liveBroadcastContent = json['liveBroadcastContent'];
		publishTime = json['publishTime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['publishedAt'] = publishedAt;
		data['channelId'] = channelId;
		data['title'] = title;
		data['description'] = description;
		if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.toJson();
    }
		data['channelTitle'] = channelTitle;
		data['liveBroadcastContent'] = liveBroadcastContent;
		data['publishTime'] = publishTime;
		return data;
	}
}

class Thumbnails {
	Default? Thumbnailsdefault;
	Default? medium;
	Default? high;

	Thumbnails({this.Thumbnailsdefault, this.medium, this.high});

	Thumbnails.fromJson(Map<String, dynamic> json) {
		Thumbnailsdefault = json['default'] != null ? Default.fromJson(json['default']) : null;
		medium = json['medium'] != null ? Default.fromJson(json['medium']) : null;
		high = json['high'] != null ? Default.fromJson(json['high']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (Thumbnailsdefault != null) {
      data['default'] = Thumbnailsdefault!.toJson();
    }
		if (medium != null) {
      data['medium'] = medium!.toJson();
    }
		if (high != null) {
      data['high'] = high!.toJson();
    }
		return data;
	}
}

class Default {
	String? url;
	int? width;
	int? height;

	Default({this.url, this.width, this.height});

	Default.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		width = json['width'];
		height = json['height'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['url'] = url;
		data['width'] = width;
		data['height'] = height;
		return data;
	}
}


