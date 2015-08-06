class AnswerItem extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return(
      <div className='answer-item'>
        <div className='answer-avatar'>
          <img src={this.props.user.gravatar_url} className='avatar' />
        </div>
        <div className='answer-body'>
          <div className='answer-header'>
            {this.props.user.github_nickname}
          </div>
          <div className='answer-content' dangerouslySetInnerHTML={{__html: this.props.content}}></div>
        </div>
      </div>
    )
  }
}