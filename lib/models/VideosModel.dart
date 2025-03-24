class VideosModel {
	String? kind;
	String? etag;
	String? nextPageToken;
	List<VideoItems>? videos;
	PageInfo? pageInfo;

	VideosModel({this.kind, this.etag, this.nextPageToken, this.videos, this.pageInfo});

	VideosModel.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		etag = json['etag'];
		nextPageToken = json['nextPageToken'];
		if (json['items'] != null) {
			videos = <VideoItems>[];
			json['items'].forEach((v) { videos!.add( VideoItems.fromJson(v)); });
		}
		pageInfo = json['pageInfo'] != null ?  PageInfo.fromJson(json['pageInfo']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data =  <String, dynamic>{};
		data['kind'] = kind;
		data['etag'] = etag;
		data['nextPageToken'] = nextPageToken;
		if (videos != null) {
      data['items'] = videos!.map((v) => v.toJson()).toList();
    }
		if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
		return data;
	}
}

class VideoItems {
	String? kind;
	String? etag;
	String? id;
	Video? video;

	VideoItems({this.kind, this.etag, this.id, this.video});

	VideoItems.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		etag = json['etag'];
		id = json['id'];
		video = json['snippet'] != null ?  Video.fromJson(json['snippet']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['kind'] = kind;
		data['etag'] = etag;
		data['id'] = id;
		if (video != null) {
      data['snippet'] = video!.toJson();
    }
		return data;
	}
}

class Video {
	String? publishedAt;
	String? channelId;
	String? title;
	String? description;
	Thumbnails? thumbnails;
	String? channelTitle;
	String? playlistId;
	int? position;
	ResourceId? resourceId;
	String? videoOwnerChannelTitle;
	String? videoOwnerChannelId;

	Video({this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.playlistId, this.position, this.resourceId, this.videoOwnerChannelTitle, this.videoOwnerChannelId});

	Video.fromJson(Map<String, dynamic> json) {
		publishedAt = json['publishedAt'];
		channelId = json['channelId'];
		title = json['title'];
		description = json['description'];
		thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
		channelTitle = json['channelTitle'];
		playlistId = json['playlistId'];
		position = json['position'];
		resourceId = json['resourceId'] != null ? ResourceId.fromJson(json['resourceId']) : null;
		videoOwnerChannelTitle = json['videoOwnerChannelTitle'];
		videoOwnerChannelId = json['videoOwnerChannelId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['publishedAt'] = publishedAt;
		data['channelId'] = channelId;
		data['title'] = title;
		data['description'] = description;
		if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.toJson();
    }
		data['channelTitle'] = channelTitle;
		data['playlistId'] = playlistId;
		data['position'] = position;
		if (resourceId != null) {
      data['resourceId'] = resourceId!.toJson();
    }
		data['videoOwnerChannelTitle'] = videoOwnerChannelTitle;
		data['videoOwnerChannelId'] = videoOwnerChannelId;
		return data;
	}
}

class Thumbnails {
	Default? ThumbnailsDefault;
	Default? medium;
	Default? high;
	Default? standard;
	Default? maxres;

	Thumbnails({this.ThumbnailsDefault, this.medium, this.high, this.standard, this.maxres});

	Thumbnails.fromJson(Map<String, dynamic> json) {
		ThumbnailsDefault = json['default'] != null ? Default.fromJson(json['default']) : null;
		medium = json['medium'] != null ? Default.fromJson(json['medium']) : null;
		high = json['high'] != null ? Default.fromJson(json['high']) : null;
		standard = json['standard'] != null ? Default.fromJson(json['standard']) : null;
		maxres = json['maxres'] != null ? Default.fromJson(json['maxres']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (ThumbnailsDefault != null) {
      data['default'] = ThumbnailsDefault!.toJson();
    }
		if (medium != null) {
      data['medium'] = medium!.toJson();
    }
		if (high != null) {
      data['high'] = high!.toJson();
    }
		if (standard != null) {
      data['standard'] = standard!.toJson();
    }
		if (maxres != null) {
      data['maxres'] = maxres!.toJson();
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

class ResourceId {
	String? kind;
	String? videoId;

	ResourceId({this.kind, this.videoId});

	ResourceId.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		videoId = json['videoId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['kind'] = kind;
		data['videoId'] = videoId;
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


