import React from 'react';
import axios from 'axios';
import '../App.css';

class BackgroundImageRefresh extends React.Component {
    constructor() {
      super();
      this.state = {
          image: ""
      };
      this.getImage = this.getImage.bind(this);
      this.onClick = this.onClick.bind(this);
    }

    getImage(){
        const url = `${process.env.REACT_APP_CORS_PROXY}/${process.env.REACT_APP_PANDA_IMAGE_URL}`
        axios.get(url)
        .then(res => {
            this.setState({image: res.data.link})
        })
        .catch(error => {
            console.log(error)
        })
    }

    componentDidMount(){
        this.getImage()
    }

    onClick() {
        this.getImage()
    }

    render() {
        const backgroundImage = {
            backgroundImage: `url(${this.state.image})`,
            backgroundRepeat: 'no-repeat',
            backgroundPosition: 'center',
            backgroundSize: 'cover',
            width: '100%',
            height: '900px',
            marginTop: '-265px'
        }
        return (
            <div style={backgroundImage}>
                <div onClick={this.onClick} className="get_background">Panda Background</div>
            </div>
          );
    }
}

export default BackgroundImageRefresh;
