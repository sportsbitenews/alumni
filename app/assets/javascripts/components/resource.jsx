class Resource extends React.Component {
  render() {
    var upVoters = this.props.up_voters;
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
       <PostDetailFooter {...this.props} />
      </div>
    )
  }
}
