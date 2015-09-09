class AnswerItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      highlighted: false,
      isEditing: false,
      content: this.props.content,
      original_content: this.props.original_content
    }
  }

  render() {
    var answerItemId = classNames({
      'highlighted': this.state.highlighted
    });

    var editItem = classNames({
      'answer-item-share': true,
      'is-hidden': !this.props.is_mine
    })

    var answerItemClasses = classNames({
      'answer-item': true,
      'is-editing': this.state.isEditing
    })

    return(
      <div className={answerItemClasses} id={answerItemId}>
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
          <div className='answer-content' dangerouslySetInnerHTML={{__html: this.state.content}}></div>
          <div className='answer-edit'>
            <textarea
              className='answer-form-edit'
              ref='editForm'
              defaultValue={this.state.original_content}
            />
            <div className='button button-success' onClick={this.updateAnswer.bind(this)}>
              Edit your answer
            </div>
          </div>
          <div className='answer-item-menu'>
            <div className={editItem} onClick={this.handleEditionMode.bind(this)}>
              EDIT
            </div>
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

    AnswerStore.listen(this.onStoreChange.bind(this))
  }

  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange.bind(this))
  }

  handleEditionMode() {
    this.setState({ isEditing: !this.state.isEditing })
  }

  updateAnswer() {
    AnswerActions.update(this.props.id, React.findDOMNode(this.refs.editForm).value)
  }

  onStoreChange(store) {
    if (store.updated_answer.id == this.props.id) {
      this.setState ({
        isEditing: false,
        original_content: store.updated_answer.original_content,
        content: store.updated_answer.content
      })
    }
  }

  displaySharingUrl() {
    if (this.props.type == 'FirstItem') {
      var link = window.location.href
    } else {
      var path = `${this.props.answerable_type.toLowerCase()}_path`;
      var link = `${window.location.origin}${Routes[path]({ id: this.props.answerable_id })}#answer-${this.props.id}`
    }
    window.prompt("Copy to clipboard", link);
  }



}
