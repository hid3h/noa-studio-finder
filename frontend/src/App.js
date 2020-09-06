import React, { useState } from 'react';
import 'antd/dist/antd.css';
import './App.css';

import Axios from 'axios'

import { Layout, Table } from 'antd';
import { Button } from 'antd';
import { SearchOutlined } from '@ant-design/icons';

const { Footer, Content } = Layout;

const apiBaseUrl = process.env.NODE_ENV === 'production' ? 'https://ponest.net/api/v1' : 'http://127.0.0.1:2002/api/v1'
const axios = Axios.create({
  baseURL: apiBaseUrl
})

const title = "ノアスタジオかんたん検索(非公式)"

function App() {
  const [loading, setLoading] = useState(false)
  const [columns, setColumns] = useState([])
  const [dataSource, setDataSource] = useState([])


  function search() {
    setLoading(true)
    axios.get('/studios')
    .then((res) => {
      console.log('res', res)

      const tempColumns = [
        {
          title: '時間',
          dataIndex: 'time',
          key: 'time'
        }
      ]
      const tempdataSource = []
      Object.keys(res.data).map((studioId, index) => {
        const studio = res.data[studioId]
        tempColumns.push({
          title: studio["web_branch_name"] + studio["studio_name"],
          dataIndex: studioId,
          key: studioId
        })

        if (index < 18) {
          // 23時まで追加
          const param = {
            key: index,
            time: 6 + index
          }
          Object.keys(res.data).map((studioId) => {
            const studio = res.data[studioId]
            param[studioId] = studio["aki"][6 + index] ? studio["aki"][6 + index]["price"] : "☓"
          })
        　tempdataSource.push(param)
        }
      })

      setColumns(tempColumns)
      setDataSource(tempdataSource)
    })

    setLoading(false)
  }

  return (
    <>
      <Layout>
        <h1>{title}</h1>
        <Content>
          <div>
            <Button type="primary" icon={<SearchOutlined />} size='large' loading={loading} onClick={search}>
              スタジオ検索
            </Button>
          </div>
          <div>
            <Table dataSource={dataSource} columns={columns} pagination={false} />;
          </div>
        </Content>
        <Footer>Footer</Footer>
      </Layout>
    </>
  );
}

export default App;
