import 'package:flutter_rhine/common/model/user_Introduction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue.g.dart';

List<Issue> getIssueList(List<dynamic> list){
  List<Issue> result = [];
  list.forEach((item){
    result.add(Issue.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Issue extends Object {

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'repository_url')
  String repositoryUrl;

  @JsonKey(name: 'labels_url')
  String labelsUrl;

  @JsonKey(name: 'comments_url')
  String commentsUrl;

  @JsonKey(name: 'events_url')
  String eventsUrl;

  @JsonKey(name: 'html_url')
  String htmlUrl;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'node_id')
  String nodeId;

  @JsonKey(name: 'number')
  int number;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'user')
  UserIntro user;

  @JsonKey(name: 'labels')
  List<IssueLabels> labels;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'locked')
  bool locked;

  @JsonKey(name: 'assignee')
  UserIntro assignee;

  @JsonKey(name: 'assignees')
  List<UserIntro> assignees;

  @JsonKey(name: 'comments')
  int comments;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'author_association')
  String authorAssociation;

  @JsonKey(name: 'repository')
  Repository repository;

  @JsonKey(name: 'body')
  String body;

  Issue(this.url,this.repositoryUrl,this.labelsUrl,this.commentsUrl,this.eventsUrl,this.htmlUrl,this.id,this.nodeId,this.number,this.title,this.user,this.labels,this.state,this.locked,this.assignee,this.assignees,this.comments,this.createdAt,this.updatedAt,this.authorAssociation,this.repository,this.body,);

  factory Issue.fromJson(Map<String, dynamic> srcJson) => _$IssueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IssueToJson(this);

}

@JsonSerializable()
class IssueLabels extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'node_id')
  String nodeId;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'color')
  String color;

  @JsonKey(name: 'default')
  bool isDefault;

  IssueLabels(this.id,this.nodeId,this.url,this.name,this.color,this.isDefault,);

  factory IssueLabels.fromJson(Map<String, dynamic> srcJson) => _$IssueLabelsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IssueLabelsToJson(this);

}

@JsonSerializable()
class Repository extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'node_id')
  String nodeId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'full_name')
  String fullName;

  @JsonKey(name: 'private')
  bool private;

  @JsonKey(name: 'owner')
  UserIntro owner;

  @JsonKey(name: 'html_url')
  String htmlUrl;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'fork')
  bool fork;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'forks_url')
  String forksUrl;

  @JsonKey(name: 'keys_url')
  String keysUrl;

  @JsonKey(name: 'collaborators_url')
  String collaboratorsUrl;

  @JsonKey(name: 'teams_url')
  String teamsUrl;

  @JsonKey(name: 'hooks_url')
  String hooksUrl;

  @JsonKey(name: 'issue_events_url')
  String issueEventsUrl;

  @JsonKey(name: 'events_url')
  String eventsUrl;

  @JsonKey(name: 'assignees_url')
  String assigneesUrl;

  @JsonKey(name: 'branches_url')
  String branchesUrl;

  @JsonKey(name: 'tags_url')
  String tagsUrl;

  @JsonKey(name: 'blobs_url')
  String blobsUrl;

  @JsonKey(name: 'git_tags_url')
  String gitTagsUrl;

  @JsonKey(name: 'git_refs_url')
  String gitRefsUrl;

  @JsonKey(name: 'trees_url')
  String treesUrl;

  @JsonKey(name: 'statuses_url')
  String statusesUrl;

  @JsonKey(name: 'languages_url')
  String languagesUrl;

  @JsonKey(name: 'stargazers_url')
  String stargazersUrl;

  @JsonKey(name: 'contributors_url')
  String contributorsUrl;

  @JsonKey(name: 'subscribers_url')
  String subscribersUrl;

  @JsonKey(name: 'subscription_url')
  String subscriptionUrl;

  @JsonKey(name: 'commits_url')
  String commitsUrl;

  @JsonKey(name: 'git_commits_url')
  String gitCommitsUrl;

  @JsonKey(name: 'comments_url')
  String commentsUrl;

  @JsonKey(name: 'issue_comment_url')
  String issueCommentUrl;

  @JsonKey(name: 'contents_url')
  String contentsUrl;

  @JsonKey(name: 'compare_url')
  String compareUrl;

  @JsonKey(name: 'merges_url')
  String mergesUrl;

  @JsonKey(name: 'archive_url')
  String archiveUrl;

  @JsonKey(name: 'downloads_url')
  String downloadsUrl;

  @JsonKey(name: 'issues_url')
  String issuesUrl;

  @JsonKey(name: 'pulls_url')
  String pullsUrl;

  @JsonKey(name: 'milestones_url')
  String milestonesUrl;

  @JsonKey(name: 'notifications_url')
  String notificationsUrl;

  @JsonKey(name: 'labels_url')
  String labelsUrl;

  @JsonKey(name: 'releases_url')
  String releasesUrl;

  @JsonKey(name: 'deployments_url')
  String deploymentsUrl;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'pushed_at')
  String pushedAt;

  @JsonKey(name: 'git_url')
  String gitUrl;

  @JsonKey(name: 'ssh_url')
  String sshUrl;

  @JsonKey(name: 'clone_url')
  String cloneUrl;

  @JsonKey(name: 'svn_url')
  String svnUrl;

  @JsonKey(name: 'homepage')
  String homepage;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'stargazers_count')
  int stargazersCount;

  @JsonKey(name: 'watchers_count')
  int watchersCount;

  @JsonKey(name: 'language')
  String language;

  @JsonKey(name: 'has_issues')
  bool hasIssues;

  @JsonKey(name: 'has_projects')
  bool hasProjects;

  @JsonKey(name: 'has_downloads')
  bool hasDownloads;

  @JsonKey(name: 'has_wiki')
  bool hasWiki;

  @JsonKey(name: 'has_pages')
  bool hasPages;

  @JsonKey(name: 'forks_count')
  int forksCount;

  @JsonKey(name: 'archived')
  bool archived;

  @JsonKey(name: 'disabled')
  bool disabled;

  @JsonKey(name: 'open_issues_count')
  int openIssuesCount;

  @JsonKey(name: 'forks')
  int forks;

  @JsonKey(name: 'open_issues')
  int openIssues;

  @JsonKey(name: 'watchers')
  int watchers;

  @JsonKey(name: 'default_branch')
  String defaultBranch;

  Repository(this.id,this.nodeId,this.name,this.fullName,this.private,this.owner,this.htmlUrl,this.description,this.fork,this.url,this.forksUrl,this.keysUrl,this.collaboratorsUrl,this.teamsUrl,this.hooksUrl,this.issueEventsUrl,this.eventsUrl,this.assigneesUrl,this.branchesUrl,this.tagsUrl,this.blobsUrl,this.gitTagsUrl,this.gitRefsUrl,this.treesUrl,this.statusesUrl,this.languagesUrl,this.stargazersUrl,this.contributorsUrl,this.subscribersUrl,this.subscriptionUrl,this.commitsUrl,this.gitCommitsUrl,this.commentsUrl,this.issueCommentUrl,this.contentsUrl,this.compareUrl,this.mergesUrl,this.archiveUrl,this.downloadsUrl,this.issuesUrl,this.pullsUrl,this.milestonesUrl,this.notificationsUrl,this.labelsUrl,this.releasesUrl,this.deploymentsUrl,this.createdAt,this.updatedAt,this.pushedAt,this.gitUrl,this.sshUrl,this.cloneUrl,this.svnUrl,this.homepage,this.size,this.stargazersCount,this.watchersCount,this.language,this.hasIssues,this.hasProjects,this.hasDownloads,this.hasWiki,this.hasPages,this.forksCount,this.archived,this.disabled,this.openIssuesCount,this.forks,this.openIssues,this.watchers,this.defaultBranch,);

  factory Repository.fromJson(Map<String, dynamic> srcJson) => _$RepositoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);

}