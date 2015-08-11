class Question extends React.Component {
  render() {
    return (
      <div className='post-detail'>
        <div className='post-detail-header question-detail'>
          <div className='container'>
            <div className='post-detail-name post-detail-name-reduce'>{this.props.title}</div>
            <div className='post-detail-tagline'>{this.props.tagline}</div>
            <div className='post-detail-header-action'>
              <div className='post-detail-upvote'>
                <Upvote {...this.props} />
              </div>
              <a href={this.props.url} target='_blank'>
                <div className='post-detail-url'>
                  Not solved
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
