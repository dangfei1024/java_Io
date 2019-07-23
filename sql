  <select id="selectTenderInfo"   parameterType = "etrade.product.bean.ProdSelectTenderInfoBean"  resultType="etrade.product.bean.TenderInfoBean">
   	SELECT
	tendInfo.TENDER_NO tenderNo,
	tendInfo.TENDER_NAME tenderName,
	DATE_FORMAT(tendInfo.PUBLISHED_DT,'%Y-%m-%d %H:%i:%s') publishedDt,
	DATE_FORMAT(tendInfo.REPLY_START_DT,'%Y-%m-%d %H:%i:%s') replyStartDt,
	DATE_FORMAT(tendInfo.REPLY_END_DT,'%Y-%m-%d %H:%i:%s') replyEndDt,
	DATE_FORMAT(tendInfo.QA_DT,'%Y-%m-%d %H:%i:%s') qaDt,
	tendInfo.CATEGORY_ID categoryId,
	tendInfo.TENDER_CORP_ID tenderCorpId,
	tendInfo.TENDER_STATUS tenderStatus,
	tendInfo.PERSON_IN_CHARGE
	FROM pd_tender_info tendInfo
	WHERE tendInfo.REC_STAT = '1'
	AND tendInfo.TENDER_CORP_ID = #{infoBean.tenderCorpId}
	<if test="infoBean.tenderNo != null and infoBean.tenderNo !=''">
		AND tendInfo.TENDER_NO like CONCAT(CONCAT('%',#{infoBean.tenderNo,jdbcType=VARCHAR}),'%')
	</if>
	<if test="infoBean.searchDtFrom != null">
		 <![CDATA[AND DATE_FORMAT(tendInfo.REPLY_END_DT,'%Y-%m-%d %H:%i:%s') >= DATE_FORMAT(#{infoBean.searchDtFrom},'%Y-%m-%d %H:%i:%s')]]>
	</if>
	<if test="infoBean.searchDtTo != null">
		 <![CDATA[AND DATE_FORMAT(tendInfo.REPLY_END_DT,'%Y-%m-%d %H:%i:%s') <= DATE_FORMAT(#{infoBean.searchDtTo},'%Y-%m-%d %H:%i:%s')]]>
	</if>
	<if test="infoBean.tenderName != null and infoBean.tenderName != ''">
		AND tendInfo.TENDER_NAME like CONCAT(CONCAT('%',#{infoBean.tenderName,jdbcType=VARCHAR}),'%')
	</if>
	<if test="infoBean.tenderStatusList != null and infoBean.tenderStatusList.size()>0">
		AND tendInfo.TENDER_STATUS IN
		<foreach collection="infoBean.tenderStatusList" open="(" close=")" separator="," item="tenderStatus" index="index">
			#{tenderStatus}
		</foreach>
	</if>
	ORDER BY tendInfo.UPT_TM desc
  </select>
