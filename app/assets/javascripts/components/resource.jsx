class Resource extends React.Component {
  render() {
    var upVoters = this.props.up_voters;
    var gradient = "linear-gradient(90deg, rgba(255, 179, 71, 0.9) 10%, rgba(255, 204, 51, 0.9) 90%)"
    var headerStyle = {
      background: gradient + ", url('https://wagon-screenshot-as-a-service.herokuapp.com/?url=" + this.props.url + "&width=1600&height=600')",
      backgroundSize: 'cover'
    }
    return (
      <div className='post-detail'>
        <div className='post-detail-header resource-detail' style={headerStyle  }>
          <div className='post-detail-header-main'>
            <a href={this.props.url} >
              <div className='post-detail-name'>{this.props.title}</div>
            </a>
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
              <div className='post-detail-author'>
                <a href={Routes.profile_path(this.props.user.github_nickname)}>
                  <div>
                    <img src={this.props.user.thumbnail} />
                  </div>
                </a>
              </div>
            </div>
          </div>
        </div>
       <PostDetailBody {...this.props} />
       <PostDetailFooter {...this.props} />
      </div>
    )
  }
}
