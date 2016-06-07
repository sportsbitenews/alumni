var CityMembersList = React.createClass({
  getInitialState() {
    return {
      members: this.props.members
    };
  },
  updateMembersList: function(members) {
    this.setState({members: members});
  },
  render: function() {
    var membersListClasses = classNames({
      'col-xs-12': true,
      'col-sm-3': this.props.role == 'teacher_assistant'
    })
    return (
      <div className="row">
        {this.state.members.map((member, index) => {
          var menuBtn = null;
          if (this.props.role == 'teacher') {
            menuBtn =(
              <div>
                <button ref={'edit_btn_'+member.github_nickname} className='manager-button manager-button-edit'
                    onClick={(e) => { this.handleEditClick(e, member) }} >
                  <i className="mdi mdi-menu-down" />
                </button>
                <button ref={'close_btn_'+member.github_nickname} className='manager-button manager-button-close hidden'
                    onClick={(e) => { this.handleCloseClick(e, member) }} >
                  <i className="mdi mdi-menu-up" />
                </button>
              </div>
            );
          }
          var additionalFields = null;
          if (this.props.role == 'teacher') {
            additionalFields = (
              <div className='hidden' ref={'edit_'+ member.github_nickname}>
                <div className='city_edit_teacher_info'>
                  <form action="" className="simple_form padded-1em side-padded-1em" onSubmit={(e) => { this.handleSubmit(e, member) }}>
                    <div className='bottom-padded-05em flex'>
                      <div className='teacher_info_input'>
                        <div className='teacher_info_label'>Role</div>
                        <div className=''>
                          <input className='form-control' type="text" name='role' defaultValue={member.role} ref={member.github_nickname+'_role'} />
                        </div>
                      </div>
                      <div className='teacher_info_input'>
                        <div className='teacher_info_label twitter'><i className="mdi mdi-twitter" /></div>
                        <div className=''>
                          <input className='form-control' type="text" name='twitter_nickname' defaultValue={member.twitter_nickname} ref={member.github_nickname+'_twitter_nickname'} />
                        </div>
                      </div>
                    </div>
                    <div className='bottom-padded-05em flex'>
                      <div className='teacher_info_area'>
                        <div className='teacher_info_label'>Bio 🇫🇷</div>
                        <textarea className='form-control' type="text" name='bio_fr' defaultValue={member.bio_fr} ref={member.github_nickname+'_bio_fr'} />
                      </div>
                    </div>
                    <div className='bottom-padded-05em flex'>
                      <div className='teacher_info_area'>
                        <div className='teacher_info_label'>Bio 🇬🇧</div>
                        <textarea className='form-control' type="text" name='bio_en' defaultValue={member.bio_en} ref={member.github_nickname+'_bio_en'} />
                      </div>
                    </div>
                    <button className='btn btn-primary' type='submit'>Update</button>
                  </form>
                </div>
              </div>
            );
          }
          return (
            <div className={membersListClasses} key={index}>
              <div className="manager-box" key={index}>
                <div className="manager-avatar">
                  <img className="avatar" src={member.gravatar_url} alt="" />
                </div>
                <div className="manager-username">
                  {member.github_nickname}
                </div>
                {menuBtn}
                <button className='manager-button manager-button-kill'
                    onClick={(e) => { this.handleRemoveClick(e, member) }} >
                  <i className="mdi mdi-window-close" />
                </button>
              </div>
              {additionalFields}
            </div>
          )
        })}
        <div className="col-xs-12" >
          <TeamMemberForm
            city={this.props.city}
            memberRole={this.props.role}
            updateMembersList={this.updateMembersList} />
        </div>
      </div>
    );
  },
  handleSubmit(e, member) {
    e.preventDefault();
    axios.railsPatch(
      Routes.user_path(member.github_nickname, { format: 'json' }),
      {
        'twitter_nickname': React.findDOMNode(this.refs[member.github_nickname+'_twitter_nickname']).value,
        'role': React.findDOMNode(this.refs[member.github_nickname+'_role']).value,
        'bio_en': React.findDOMNode(this.refs[member.github_nickname+'_bio_en']).value,
        'bio_fr': React.findDOMNode(this.refs[member.github_nickname+'_bio_fr']).value,
        'from_back_office': true
      }
    ).then((response) => {
      handleCloseClick(e, member);
      // this.setState({
      //   errors: response.data.errors,
      //   errorContent: response.data.error_content
      // });
      // this.props.updateMembersList(response.data.members);
      // React.findDOMNode(this.refs.memberSlug).value = '';
    });
  },
  handleEditClick(e, member) {
    var editBtnRef = 'edit_btn_'+member.github_nickname;
    var closeBtnRef = 'close_btn_'+member.github_nickname;
    var editBoxRef = 'edit_' + member.github_nickname;
    React.findDOMNode(this.refs[editBtnRef]).className+=' hidden';
    React.findDOMNode(this.refs[closeBtnRef]).classList.remove('hidden');
    React.findDOMNode(this.refs[editBoxRef]).className='';
  },
  handleCloseClick(e, member) {
    var editBoxRef = 'edit_' + member.github_nickname;
    var editBtnRef = 'edit_btn_'+member.github_nickname;
    var closeBtnRef = 'close_btn_'+member.github_nickname;
    React.findDOMNode(this.refs[editBtnRef]).classList.remove('hidden');
    React.findDOMNode(this.refs[closeBtnRef]).className+=' hidden';
    React.findDOMNode(this.refs[editBoxRef]).className='hidden';
  },
  handleRemoveClick(e, member) {
    e.preventDefault();
    axios.railsPatch(
      Routes.city_ordered_lists_path(member.city, { format: 'json' }),
      {
        'github_nickname': member.github_nickname,
        'role': this.props.role,
        'remove': true
      }
    ).then((response) => {
      this.updateMembersList(response.data.members);
    });
  }
});
