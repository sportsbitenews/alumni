class Upvote extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      up_votes: props.up_votes,
      upvoted: props.upvoted
    };
  }
  render() {
    var upvoteClasses = classNames({
      'upvote': true,
      'is-upvoted': this.state.upvoted
    });
    return(
      <div onClick={this.up_vote.bind(this)} className={upvoteClasses}>
        <div className='upvote-item'>
          <figure />
        </div>
        <div className='upvote-count'>
          {this.state.up_votes.length}
        </div>
      </div>
    )
  }

  up_vote(e) {
    $.post(
      Routes.up_vote_post_path(this.props.id),
      { type: this.props.type },
      (data) => {
        this.setState({
          up_votes: data.up_votes,
          upvoted: data.upvoted
        });
      }
    );
    e.preventDefault();
  }
}