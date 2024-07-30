# gh2gl
Github to Gitlab Migration

# Get the list of repositories under given organization

The below command creates something like this: 

```
repo_name_1 234
repo_name_2 2939
```
Where the first column is repository name and the second one is its ID

```bash
./list_repos_of_an_organization.sh <FILE_NAME_TO_WRITE> <GITHUT_TOKEN> <GITHUB_HOSTNAME> <ORGANIZATION_NAME>
```
Where;
* GITHUB_TOKEN is your personal token
* GITHUB_HOSTNAME is the Github hostname of your organization. It can be either `github.com` or `github.enterprise.private.hostname`
* ORGANIZATION_NAME is where your repo resides for this repo, it is COvayurt. See the URL.


# Finding the biggest files in the git

The size matters sometimes. If the gitlab repo has no LFS enabled, 
you need to know whether there are files which are more than 10 MB. 

Caveat: You need to have access to these repositories, such as cloning it

```bash
./get_biggest_file_sizes_of_given_repos.sh <FILE_NAME_TO_READ> <GIT_ORGANIZATION_URL>
```
Where;
* GIT_ORGANIZATION_URL is the base URL of all the repositories

# Count all the comments

This migration supports migrating maximum of 30000 comments for each repo. The below command counts the comments for you

```bash
./number_of_comments_in_project.sh <GITHUB_TOKEN> <REPO_OWNER_OR_ORG> <REPO_NAME> <GITHUB_HOSTNAME>
```

Where;
* GITHUB_TOKEN is your personal token
* GITHUB_HOSTNAME is the Github hostname of your organization. It can be either `github.com` or `github.enterprise.private.hostname`
* REPO_NAME you should give the repo name which you want to count comments in it
* REPO_OWNER_OR_ORG is where your repo resides for this repo, it is COvayurt. See the URL.


# Migrate the repositories from the list

```bash
./migrate_gh_2_gl.sh <FILE_NAME_TO_READ> <GITLAB_TOKEN> <GITHUB_TOKEN> <GITLAB_HOSTNAME> <GITHUB_URL> <TARGET_NAMESPACE>
```

Where;
* GITHUB_TOKEN is your personal token for github
* GITLAB_TOKEN is your personal token for gitlab
* GITLAB_HOSTNAME is the Gitlab hostname of your organization. It can be either `gitlab.com` or `gitlab.enterprise.private.hostname` 
* GITHUB_HOSTNAME is the Github hostname of your organization. It can be either `github.com` or `github.enterprise.private.hostname`
* TARGET_NAMESPACE is the namespace that your repository will be created under. It would be something like `covayurt/github-tools` for this `gh2gl` repo

