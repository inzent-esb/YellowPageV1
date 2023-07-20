/*******************************************************************************
 * This program and the accompanying materials are made
 * available under the terms of the Inzent MCA License v1.0
 * which accompanies this distribution.
 * 
 * Contributors:
 *     Inzent Corporation - initial API and implementation
 *******************************************************************************/
package com.inzent.yellowpage.interfaces ;

import java.util.LinkedList ;
import java.util.List ;
import java.util.stream.Stream ;

import org.apache.commons.lang3.StringUtils ;
import org.springframework.stereotype.Component ;

import com.inzent.yellowpage.model.MappingRule ;
import com.inzent.yellowpage.model.MappingRuleDetail ;
import com.inzent.yellowpage.model.ModelField ;
import com.inzent.yellowpage.model.ModelRecord ;

/**
 * <code>AutoMappingBean</code>
 *
 * @since 2021. 12. 31.
 * @version 5.0
 * @author jaesuk byon
 */
@Component
public class AutoMappingBean extends AutoMapping
{
  @Override
  public void autoMapping(MappingRule mappingRule)
  {
    // 입출력 모델의 metaDomain으로 1:1 여부를 판단하는 예제입니다.
    ModelRecord target = mappingRule.getRecordObject() ;
    ModelRecord source = mappingRule.getMappingRuleSources().get(0).getRecordObject() ;
    if ("대외 도메인".equals(target.getMetaDomain()) || "대외 도메인".equals(source.getMetaDomain()))
    {
      LinkedList<MappingField> targetFields = new LinkedList<MappingField>() ;
      setParent(target, null) ;
      makeTargetField(target, targetFields) ;

      LinkedList<MappingField> sourceFields = new LinkedList<MappingField>() ;
      setParent(source, null) ;
      makeTargetField(source, sourceFields) ;

      LinkedList<MappingRuleDetail> mappingRuleDetails = new LinkedList<MappingRuleDetail>() ;
      int ix = 0 ;
      for (MappingField targetField : targetFields)
      {
        List<ModelField> sourceFieldDepth = getFieldDepth(sourceFields.get(ix++).fieldDepth.stream().findFirst().get()) ;

        MappingRuleDetail mappingRuleDetail = new MappingRuleDetail() ;

        mappingRuleDetail.setTargetFieldPath(getFieldPath(getFieldDepth(targetField.fieldDepth.stream().findFirst().get()), true)) ;

        mappingRuleDetail.setMappingExpression(MAPPING_EXPRESSION_RECORD_INDEX_STRING + "0" + getFieldPath(sourceFieldDepth, true)) ;

        String arraySize = getArraySizeParameter(sourceFieldDepth) ;
        if (!StringUtils.isBlank(arraySize))
          mappingRuleDetail.setArraySizeParameter(MAPPING_EXPRESSION_RECORD_INDEX_STRING + "0" + arraySize) ;

        mappingRuleDetails.add(mappingRuleDetail) ;
      }

      mappingRule.setMappingRuleDetails(mappingRuleDetails) ;
    }
    else
      super.autoMapping(mappingRule) ;
  }

  @Override
  protected Stream<MappingField> filtering(MappingField targetField, Stream<MappingField> stream)
  {
    return stream.filter(source -> targetField.arrayDepth == source.arrayDepth) ;
  }
}
