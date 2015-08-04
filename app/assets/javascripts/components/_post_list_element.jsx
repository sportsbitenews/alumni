class PostListElement extends React.Component {
  render() {
    var path = `${this.props.type.toLowerCase()}_path`;
    var link = Routes[path]({ id: this.props.id });

    return (
      <a href={link}>
        <div className='post-item'>
            <div className='post-item-upvote'>
              <Upvote {...this.props} />
            </div>

          <div className='post-item-thumbnail' />
          <div className='post-item-text'>
            <div className='post-item-text-name'>
              {this.props.title}
            </div>
            <div className='post-item-text-tagline'>
              {this.props.tagline}
            </div>
          </div>
          <div className='post-item-menu'>
            <div>
              <img src={this.props.user.gravatar_url} className='avatar' />
            </div>
          </div>
        </div>
      </a>
    )
  }
}
