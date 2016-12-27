class ProjectDetail extends React.Component {
  render() {
    var upVoters = this.props.up_voters;
    var connectedUsersWhoUpvoted = _.sumBy(upVoters, (upVoter) => upVoter.connected_to_slack ? 1 : 0);
    var sortedUpVoters = _.sortBy(
      this.props.upVoters,
      (upVoter) => upVoter.connected_to_slack ? 0 : 1,
      (upVoter) => upVoter.github_nickname.toLowerCase()
    );
    var browserStyle = {
      background: 'url(' + this.props.cover_url + ')',
      backgroundSize: 'cover',
      backgroundPosition: 'center center',
      backgroundColor: "white"

    }

    if (this.props.cover_url != '/cover_pictures/cover/missing.png') {
      var browser = (
        <div className="browser-mockup">
          <div className='browser-content' style={browserStyle} />
        </div>
      )
    }

    var batch = null;
    if (this.props.batch) {
      batch = (<a href={Routes.batch_path(this.props.batch.slug)}>
                <div className='project-detail-batch'>
                  {`Batch #${this.props.batch.slug} - ${this.props.batch.city}`}
                </div>
              </a>);
    }

    return(
      <div className='post-detail'>
        <div className='post-detail-header project-detail-header resource-detail'>
          <div className='post-detail-header-main'>
            <a href={this.props.url} >
              <div className='post-detail-name'>{this.props.name}</div>
            </a>
            <div className='post-detail-tagline'>{this.props.tagline.en}</div>
            <div className='post-detail-header-action'>
              {batch}
              <a href={this.props.url} target='_blank'>
                <div className='post-detail-url'>
                  {this.props.url.replace(/https?:\/\/w?w?w?\.?/, "").replace(/\/?$/, "")}
                </div>
              </a>
              <div className='project-detail-makers post-detail-author'>
                {this.props.makers.map(
                  (maker) => {return(
                    <a href={Routes.profile_path(maker.github_nickname)}>
                      <div>
                        <img src={maker.thumbnail} />
                      </div>
                    </a>
                  )}
                )}
              </div>
            </div>
          </div>
          {browser}
        </div>
        <div className='container'>
          {
            this.props.milestones.map(
              (milestone) => {return (
                <div className='milestone-item-container'>
                  <div className='milestone-item-date'>
                    {milestone.date}
                  </div>
                  <MilestoneListElement {...milestone} />
                </div>
              )}
            )
          }
        </div>
      </div>
    )
  }
}
