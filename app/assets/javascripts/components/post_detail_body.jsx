class PostDetailBody extends React.Component {
  render() {
    var upVotes = this.props.up_votes
    var connectedUsersWhoUpvoted = _.sum(upVotes, (upVote) => upVote.connected_to_slack ? 1 : 0);

    return (
      <div className='post-detail-body'>
        <main>
        </main>
        <aside>
          <div className='post-detail-participants'>
            <div className='section-title'>
              <i className="mdi mdi-account-outline"></i> <span className='section-title-h'>{connectedUsersWhoUpvoted}</span> / {upVotes.length} PARTICIPANTS
            </div>
            {upVotes.map(upVote => {
              var participantClasses = classNames({
                'post-detail-participant': true,
                'is-offline': !upVote.connected_to_slack
              })

              return (
                <div className={participantClasses}>
                  <div className='post-detail-participant-avatar'>
                    <img src={upVote.gravatar_url} />
                  </div>
                  <div className='post-detail-participant-name'>
                    {upVote.github_nickname}
                  </div>

                  <div className='post-detail-participant-status' />
                </div>
              )
            })}
          </div>
        </aside>
      </div>
    )
  }
}