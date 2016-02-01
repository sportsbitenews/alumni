class AnswerItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      highlighted: false,
      isEditing: false,
      content: this.props.content,
      originalContent: this.props.original_content
    }
  }

  render() {
    var answerItemId = classNames({
      'highlighted': this.state.highlighted
    });

    var editItem = classNames({
      'answer-item-share': true,
      'is-hidden': !this.props.editable || this.props.type == 'FirstItem'
    })

    var answerItemClasses = classNames({
      'answer-item': true,
      'is-editing': this.state.isEditing
    });

    return(
      <div className={answerItemClasses} id={answerItemId}>
        <div className='answer-avatar'>
          <a href={`/${this.props.user.github_nickname}`}>
            <img src={this.props.user.thumbnail} className='avatar' />
          </a>
        </div>
        <div className='answer-body'>
          <div className='answer-header'>
            <div className='answer-user-name'>
              <a href={`/${this.props.user.github_nickname}`}>
                {this.props.user.github_nickname}
              </a>
            </div>
            <div className='answer-time-ago'>
              {this.props.time_ago} ago
            </div>
            <div className='answer-item-menu'>
              <div className={editItem} onClick={this.handleEditionMode.bind(this)}>
                EDIT
              </div>
              <div className='answer-item-share' onClick={this.displaySharingUrl.bind(this)}>
                SHARE
              </div>
              <div className={editItem} onClick={this.handleDeletion.bind(this)}>
                DELETE
              </div>
            </div>
          </div>
          <div className='answer-content' dangerouslySetInnerHTML={{__html: this.state.content}}></div>
          <div className='answer-edit'>
            <textarea
              className='answer-form-edit'
              ref='editForm'
              defaultValue={this.state.originalContent}
            />
            <div className='button button-success' onClick={this.updateAnswer.bind(this)}>
              Edit your answer
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
    if (this.props.type === 'FirstItem') {
      PostStore.listen(this.onStoreChange.bind(this))
    } else {
      AnswerStore.listen(this.onStoreChange.bind(this))
    }
  }

  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange.bind(this))
  }

  handleEditionMode() {
    this.setState({ isEditing: !this.state.isEditing })
  }

  handleDeletion() {
    if (this.props.type != 'FirstItem') {
      if (confirm('Are you sure you want to delete this comment?')) {
        AnswerActions.delete(this.props.id)
      }
    }
  }

  updateAnswer() {
    if (this.props.type == 'FirstItem') {
      PostActions.update(React.findDOMNode(this.refs.editForm).value, this.props.post_type, this.props.id)
    } else {
      AnswerActions.update(this.props.id, React.findDOMNode(this.refs.editForm).value)
    }
  }

  onStoreChange(store) {
    if (this.props.type === 'FirstItem') {
      post = store.getPost(this.props.post_type, this.props.id);
      this.setState({
        isEditing: false,
        originalContent: post.original_content,
        content: post.content
      })
    } else {
      var updatedAnswer = store.getUpdatedAnswer();
      if (updatedAnswer && updatedAnswer.id == this.props.id) {
        this.setState ({
          isEditing: false,
          originalContent: updatedAnswer.original_content,
          content: updatedAnswer.content
        })
      }
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
