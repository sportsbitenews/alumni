class Resource extends React.Component {
  render() {
    var upVotes = this.props.up_votes
    return (
      <div>
        <div className='post-detail-header resource-details'>
          <div className='post-detail-name'>{this.props.title}</div>
          <div className='post-detail-tagline'>{this.props.tagline}</div>
          <div className='post-detail-header-action'>
            <div className='post-detail-upvote'>
              <Upvote {...this.props} />
            </div>
            <a href={this.props.url} target='_blank'>
              <div className='post-detail-url'>
                {this.props.url}
              </div>
            </a>
          </div>
        </div>
        <div className='post-detail-body'>
          <main>
          </main>
          <aside>
            <div className='post-detail-participants'>
              {upVotes.map(upVote =>)}
            </div>
          </aside>
        </div>
      </div>
    )
  }
}