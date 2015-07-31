class Question extends React.Component {
  render() {
    return (
      <div className='post-details'>
        <div className='post-details-header question-details'>
          <div className='container'>
            <div className='post-details-name'>{this.props.title}</div>
            <div className='post-details-tagline'>{this.props.tagline}</div>
            <div className='post-details-header-action'>
              <div className='post-details-upvote'>
                <Upvote {...this.props} />
              </div>
              <a href={this.props.url} target='_blank'>
                <div className='post-details-url'>
                  Not solved
                </div>
              </a>
            </div>
          </div>
        </div>
        <PostDetailsBody {...this.props} />
      </div>

    )
  }
}