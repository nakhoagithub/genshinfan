class ApiGithub {
  final String name;
  final String path;
  final String sha;
  final int size;
  final String url;
  final String htmlUrl;
  final String gitUrl;
  final String downloadUrl;
  final String type;
  final String content;
  final String encoding;
  final Links links;

  ApiGithub({
    required this.name,
    required this.path,
    required this.sha,
    required this.size,
    required this.url,
    required this.htmlUrl,
    required this.gitUrl,
    required this.downloadUrl,
    required this.type,
    required this.content,
    required this.encoding,
    required this.links,
  });

  factory ApiGithub.fromJson(Map<String, dynamic> json) => ApiGithub(
        name: json["name"] ?? "",
        path: json["path"] ?? "",
        sha: json["sha"] ?? "",
        size: json["size"] ?? 0,
        url: json["url"] ?? "",
        htmlUrl: json["html_url"] ?? "",
        gitUrl: json["git_url"] ?? "",
        downloadUrl: json["download_url"] ?? "",
        type: json["type"] ?? "",
        content: json["content"] ?? "",
        encoding: json["encoding"] ?? "",
        links: Links.fromJson(json["_links"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
        "sha": sha,
        "size": size,
        "url": url,
        "html_url": htmlUrl,
        "git_url": gitUrl,
        "download_url": downloadUrl,
        "type": type,
        "content": content,
        "encoding": encoding,
        "_links": links.toJson(),
      };
}

class Links {
  final String self;
  final String git;
  final String html;

  Links({
    required this.self,
    required this.git,
    required this.html,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] ?? "",
        git: json["git"] ?? "",
        html: json["html"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "git": git,
        "html": html,
      };
}
