class Question extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isSolved: this.props.solved
    }
  }
  render() {
    componentClasses = classNames({
      'post-detail': true,
      'is-editable': this.props.editable,
      'is-solved': this.state.isSolved
    })
    return (
      <div className={componentClasses}>
        <div className='post-detail-header question-detail'>
          <div className='post-detail-header-main'>
            <div className='post-detail-name post-detail-name-reduce'>{this.props.title}</div>
            <div className='post-detail-tagline'>{this.props.tagline}</div>
            <div className='post-detail-header-action'>
              <div className='post-detail-upvote'>
                <Upvote {...this.props} />
              </div>
              <a href={this.props.url} target='_blank'>
                <div className='post-detail-url question-detail-url' onClick={this.solve.bind(this)}>
                  <span className='question-detail-not-solved'>Not solved</span>
                  <span className='question-detail-solved'><i className='fa fa-check'/> Solved</span>
                </div>
              </a>
              <div className='post-detail-author'>
                <a href={Routes.profile_path(this.props.user.github_nickname)}>
                  <div>
                    <img src={this.props.user.gravatar_url} />
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

  solve() {
    if (this.props.editable) {
      axios.railsPatch(Routes.solve_question_path(this.props.id))
        .then((response) => this.setState({ isSolved: response.data.state }))
    }
  }
}
