class AnswerItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      highlighted: false
    }
  }

  render() {
    answerItemId = classNames({
      'highlighted': this.state.highlighted
    })
    return(
      <div className="answer-item" id={answerItemId}>
        <div className='answer-avatar'>
          <img src={this.props.user.gravatar_url} className='avatar' />
        </div>
        <div className='answer-body'>
          <div className='answer-header'>
            <div className='answer-user-name'>
              {this.props.user.github_nickname}
            </div>
            <div className='answer-time-ago'>
              {this.props.time_ago} ago
            </div>
          </div>
          <div className='answer-content' dangerouslySetInnerHTML={{__html: this.props.content}}></div>
          <div className='answer-item-menu'>
            <div className='answer-item-share' onClick={this.displaySharingUrl.bind(this)}>
              SHARE
            </div>
          </div>
        </div>
      </div>
    )
  }

  componentDidMount() {
    var url = window.location.href, idx = url.indexOf("#")
    var hash = idx != -1 ? url.substring(idx+1) : "";

    if (hash != "") {
      var id = parseInt(hash.substring(hash.indexOf('-') + 1))
      if (this.props.id == id) {
        this.setState({
          highlighted: true
        })

        setTimeout(function(){
          var top = document.getElementById("highlighted").offsetTop; //Getting Y of target element
          window.scrollTo(0, top);                        //Go there.
        }, 100)
      }
    }
  }

  displaySharingUrl() {
    var path = `${this.props.answerable_type.toLowerCase()}_path`;
    var link = `${window.location.origin}${Routes[path]({ id: this.props.answerable_id })}#answer-${this.props.id}`
    window.prompt("Copy to clipboard: Ctrl+C / C@md+c, Enter", link);
  }



}
