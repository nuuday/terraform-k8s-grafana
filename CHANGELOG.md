Incorrect Usage. flag provided but not defined: -next-tag 0.7.5


USAGE:
  git-chglog [options] <tag query>

    There are the following specification methods for <tag query>.

    1. <old>..<new> - Commit contained in <old> tags from <new>.
    2. <name>..     - Commit from the <name> to the latest tag.
    3. ..<name>     - Commit from the oldest tag to <name>.
    4. <name>       - Commit contained in <name>.

OPTIONS:
  --init                                generate the git-chglog configuration file in interactive
  --config value, -c value              specifies a different configuration file to pick up (default: ".chglog/config.yml")
  --output value, -o value              output path and filename for the changelogs. If not specified, output to stdout
  --next-tag value                      treat unreleased commits as specified tags (EXPERIMENTAL)
  --silent                              disable stdout output
  --no-color                            disable color output [$NO_COLOR]
  --no-emoji                            disable emoji output [$NO_EMOJI]
  --tag-filter-pattern value, -p value  Regular expression of tag filter. Is specified, only matched tags will be picked
  --help, -h                            show help
  --version, -v                         print the version
  
EXAMPLE:

  $ git-chglog

    If <tag query> is not specified, it corresponds to all tags.
    This is the simplest example.

  $ git-chglog 1.0.0..2.0.0

    The above is a command to generate CHANGELOG including commit of 1.0.0 to 2.0.0.

  $ git-chglog 1.0.0

    The above is a command to generate CHANGELOG including commit of only 1.0.0.

  $ git-chglog $(git describe --tags $(git rev-list --tags --max-count=1))

    The above is a command to generate CHANGELOG with the commit included in the latest tag.

  $ git-chglog --output CHANGELOG.md

    The above is a command to output to CHANGELOG.md instead of standard output.

  $ git-chglog --config custom/dir/config.yml

    The above is a command that uses a configuration file placed other than ".chglog/config.yml".
