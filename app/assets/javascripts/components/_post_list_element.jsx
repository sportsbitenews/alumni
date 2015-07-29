class PostListElement extends React.Component {
  constructor(props) {
    super(props);
    this.state = { up_votes: props.up_votes };  // No more getInitialState()
  }

  render() {
    return (
      <div className='post-item'>
        <div className='post-item-upvote'>
          <div onClick={this.up_vote.bind(this)} className='upvote'>
            <div className='upvote-item'>
              <figure />
            </div>
            <div className='upvote-count'>
              {this.state.up_votes.length}
            </div>
          </div>
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
            <img src={this.props.user.gravatar_url} />
          </div>
        </div>
      </div>
    )
  }

  up_vote() {
    $.post(
      Routes.up_vote_post_path(this.props.id),
      { type: this.props.type },
      (data) => {
        this.setState({ up_votes: data.up_votes });
      }
    );
  }
}
