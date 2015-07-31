class Resource extends React.Component {
  render() {
    var upVotes = this.props.up_votes;
    return (
      <div className='post-detail'>
        <div className='post-detail-header resource-detail'>
          <div className='container'>
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
        </div>
       <PostDetailBody {...this.props} />
       <div className='post-detail-footer'>
         <div className='post-detail-'>
         </div>
       </div>
      </div>
    )
  }
}
